import os
import io
import json
import qrcode
from flask import Flask, request, jsonify, send_file
from flask_cors import CORS
from dotenv import load_dotenv
import firebase_admin
from firebase_admin import credentials, firestore

# ==============================================
# 🔹 1. Load environment variables
# ==============================================
load_dotenv()

# ==============================================
# 🔹 2. Initialize Flask app
# ==============================================
app = Flask(__name__)
CORS(app)

# ==============================================
# 🔹 3. Initialize Firebase Admin SDK
# ==============================================
firebase_sdk_json_str = os.getenv("FIREBASE_ADMIN_SDK_JSON")

if not firebase_sdk_json_str:
    raise ValueError("❌ The FIREBASE_ADMIN_SDK_JSON environment variable is not set. Please check your .env file.")

try:
    # Parse the JSON string from environment variable
    firebase_sdk_json = json.loads(firebase_sdk_json_str)
    cred = credentials.Certificate(firebase_sdk_json)
except json.JSONDecodeError:
    # If parsing fails, check if it's a file path
    if os.path.isfile(firebase_sdk_json_str):
        cred = credentials.Certificate(firebase_sdk_json_str)
    else:
        raise ValueError("❌ FIREBASE_ADMIN_SDK_JSON is not valid JSON or file path.")

# Initialize Firebase App
try:
    firebase_admin.get_app()
except ValueError:
    firebase_admin.initialize_app(cred)

db = firestore.client()

print("✅ Firebase Admin SDK initialized successfully!")

# ==============================================
# 🔹 4. API Routes
# ==============================================

@app.route('/')
def api_info():
    """
    API information route
    """
    return jsonify({
        "message": "Welcome to Gurukul Manager Backend API 🚀",
        "endpoints": {
            "/generate_qr": "GET - Generates a QR code for a given course ID.",
            "/mark_attendance": "POST - Marks attendance for a student.",
            "/get_attendance": "GET - Retrieves attendance records for a student."
        }
    }), 200


@app.route('/generate_qr', methods=['GET'])
def generate_qr():
    """
    Generates a QR code for a given course ID.
    """
    try:
        course_id = request.args.get('course_id')
        if not course_id:
            return jsonify({"success": False, "error": "course_id is required"}), 400

        # Generate QR code
        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            box_size=10,
            border=4,
        )
        qr.add_data(course_id)
        qr.make(fit=True)

        img = qr.make_image(fill_color="black", back_color="white")

        # Save to in-memory buffer
        img_io = io.BytesIO()
        img.save(img_io, 'PNG')
        img_io.seek(0)

        return send_file(img_io, mimetype='image/png')

    except Exception as e:
        app.logger.error(f"Error generating QR code: {e}")
        return jsonify({"success": False, "error": str(e)}), 500


@app.route('/mark_attendance', methods=['POST'])
def mark_attendance():
    """
    Marks attendance for a student.
    """
    try:
        data = request.get_json()
        student_id = data.get('student_id')
        course_id = data.get('course_id')

        if not student_id or not course_id:
            return jsonify({"success": False, "error": "Both student_id and course_id are required"}), 400

        attendance_ref, _ = db.collection('attendance').add({
            'student_id': student_id,
            'course_id': course_id,
            'timestamp': firestore.SERVER_TIMESTAMP
        })

        return jsonify({"success": True, "attendance_id": attendance_ref.id}), 201

    except Exception as e:
        app.logger.error(f"Error marking attendance: {e}")
        return jsonify({"success": False, "error": str(e)}), 500


@app.route('/get_attendance', methods=['GET'])
def get_attendance():
    """
    Retrieves attendance records for a student.
    """
    try:
        student_id = request.args.get('student_id')
        if not student_id:
            return jsonify({"success": False, "error": "student_id is required"}), 400

        attendance_query = db.collection('attendance').where('student_id', '==', student_id).stream()
        attendance_records = [record.to_dict() for record in attendance_query]

        return jsonify({"success": True, "attendance": attendance_records}), 200

    except Exception as e:
        app.logger.error(f"Error getting attendance: {e}")
        return jsonify({"success": False, "error": str(e)}), 500


# ==============================================
# 🔹 5. Main Entry Point
# ==============================================
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
