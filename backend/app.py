from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def index():
    return "Welcome to the Attendance API!"

@app.route('/api/attendance')
def get_attendance():
    # This is a placeholder. In a real app, you would fetch this from Firestore.
    attendance_data = {
        'student_id': '12345',
        'course_id': 'CS101',
        'date': '2024-07-29',
        'status': 'present'
    }
    return jsonify(attendance_data)

if __name__ == '__main__':
    app.run(debug=True, port=5000)
