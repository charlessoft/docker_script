import os
import subprocess
from flask import Flask, request, send_file

app = Flask(__name__)

@app.route('/convert', methods=['POST'])
def convert():
    if 'file' not in request.files:
        return 'No file part', 400
    file = request.files['file']
    if file.filename == '':
        return 'No selected file', 400
    if 'target_format' not in request.form:
        return 'No target format specified', 400

    target_format = request.form['target_format']
    allowed_formats = ['pdf','txt']

    if target_format not in allowed_formats:
        return f'Invalid target format. Allowed formats are: {", ".join(allowed_formats)}', 400

    if file:
        input_path = os.path.join('/tmp', file.filename)
        output_filename = file.filename.rsplit('.', 1)[0] + '.' + target_format
        output_path = os.path.join('/tmp', output_filename)
        file.save(input_path)

        # Call the Java program to convert the file
        try:
            subprocess.run(['java', '-cp', '.:lib/aspose-words.jar', 'Office2TextTest', input_path, output_path], check=True)
        except subprocess.CalledProcessError as e:
            return f'Conversion failed: {e}', 500

        if not os.path.exists(output_path):
            return 'Conversion failed', 500

        return send_file(output_path, as_attachment=True)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
