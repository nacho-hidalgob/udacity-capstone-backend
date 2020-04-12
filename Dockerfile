FROM python:3.7.3-stretch

# Working Directory
WORKDIR /app

# Copy source code to working directory
COPY . /app/

# Install packages from requirements.txt
RUN make install-requirements

# Expose port 5000
EXPOSE 5000

# Run app.py at container launch
CMD ["python", "app.py"]
