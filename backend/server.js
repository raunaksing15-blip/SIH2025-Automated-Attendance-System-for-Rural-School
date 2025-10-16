
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

// Sample data
const subjects = [
  { id: 1, name: 'Mathematics' },
  { id: 2, name: 'Science' },
  { id: 3, name: 'History' },
];

const timetable = [
  {
    id: 1,
    day: 'Monday',
    startTime: '09:00',
    endTime: '10:00',
    subject: 'Mathematics',
    teacher: 'Mr. Smith',
  },
  {
    id: 2,
    day: 'Tuesday',
    startTime: '10:00',
    endTime: '11:00',
    subject: 'Science',
    teacher: 'Ms. Jones',
  },
];

const notices = [
  {
    id: 1,
    title: 'Holiday Notice',
    message: 'The school will be closed on Monday for a public holiday.',
    date: '2024-05-20',
  },
];

const practicals = [
  {
    id: 1,
    title: 'Physics Practical',
    description: 'Experiment on optics.',
    date: '2024-05-22',
  },
];

// Routes
app.get('/api/subjects', (req, res) => {
  res.json(subjects);
});

app.get('/api/timetable', (req, res) => {
  res.json(timetable);
});

app.get('/api/notices', (req, res) => {
  res.json(notices);
});

app.get('/api/practicals', (req, res) => {
  res.json(practicals);
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
