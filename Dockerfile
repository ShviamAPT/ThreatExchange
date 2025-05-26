# Use the official Python image from the Docker Hub, version 3.13-slim
FROM python:3.13-slim

# Update the package list and install Supervisor - git -nano, then clean up the apt cache
RUN apt-get update && \
    apt-get install -y supervisor git nano && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container to /app
WORKDIR /app

# Copy the requirements.txt file from the host to the container
COPY requirements.txt .

# Install the Python dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt --trusted-host=pypi.python.org --trusted-host=pypi.org --trusted-host=files.pythonhosted.org

# Copy the rest of the application code from the host to the container
COPY . .

# Expose port 5000 to allow external access to the application
EXPOSE 5000

# Give permission to execute prod/entrypoint.sh
RUN chmod +x prod/entrypoint.sh

# Run the application using the entrypoint.sh script
CMD ["./prod/entrypoint.sh"]