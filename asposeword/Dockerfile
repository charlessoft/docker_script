# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-slim

# Install Python and Flask
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip3 install flask

RUN apt-get install -y fonts-wqy-zenhei && \
    apt-get clean && \
        rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Download and install Aspose.Words for Java
# Note: You need to have the Aspose.Words for Java JAR file in your project directory
# If you have a license file, you should also copy it to the container
COPY aspose-words-20.12-jdk17-cracked.jar /app/lib/aspose-words.jar

# Compile the Java program
RUN javac -cp .:lib/aspose-words.jar Office2TextTest.java

# Expose the port the app runs on
EXPOSE 5000

# Run the Flask app
CMD ["python3", "app.py"]
