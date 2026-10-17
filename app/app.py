from flask import Flask, jsonify, request

app = Flask(__name__)

# Small sample records for the assignment demonstration.
students = [
    {"id": 1, "name": "Aarav Patil", "course": "CSE AIML", "year": 2},
    {"id": 2, "name": "Meera Shah", "course": "CSE AIML", "year": 2},
]
marks = []


@app.get("/")
def home():
    return jsonify({
        "message": "Student Record and Academic Management Platform",
        "endpoints": ["/api/health", "/api/students", "/api/marks"],
    })


@app.get("/api/health")
def health():
    return jsonify({"status": "UP", "service": "student-record-api"}), 200


@app.get("/api/students")
def get_students():
    return jsonify({"count": len(students), "students": students}), 200


@app.post("/api/students")
def add_student():
    data = request.get_json(silent=True) or {}
    name = str(data.get("name", "")).strip()
    course = str(data.get("course", "")).strip()
    year = data.get("year")

    if not name or not course or not isinstance(year, int) or year < 1:
        return jsonify({
            "error": "Provide name, course, and a positive integer year."
        }), 400

    student = {
        "id": max((item["id"] for item in students), default=0) + 1,
        "name": name,
        "course": course,
        "year": year,
    }
    students.append(student)
    return jsonify(student), 201


@app.post("/api/marks")
def add_marks():
    data = request.get_json(silent=True) or {}
    student_id = data.get("student_id")
    subject = str(data.get("subject", "")).strip()
    score = data.get("marks")

    if not isinstance(student_id, int) or not subject:
        return jsonify({"error": "Provide integer student_id and subject."}), 400
    if not isinstance(score, (int, float)) or isinstance(score, bool) or not 0 <= score <= 100:
        return jsonify({"error": "marks must be a number from 0 to 100."}), 400
    if not any(student["id"] == student_id for student in students):
        return jsonify({"error": "Student not found."}), 404

    record = {
        "student_id": student_id,
        "subject": subject,
        "marks": score,
    }
    marks.append(record)
    return jsonify(record), 201


@app.get("/api/marks")
def get_marks():
    return jsonify({"count": len(marks), "marks": marks}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
