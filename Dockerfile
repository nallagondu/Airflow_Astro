#FROM quay.io/astronomer/astro-runtime:11.7.0

#Bypass SSL Verification 
# Install Python dependencies with SSL verification disabled
#RUN pip install --trusted-host pip.astronomer.io --index-url https://pip.astronomer.io/v2/pip/ --no-cache-dir astro-run-dag

#FROM quay.io/astronomer/astro-runtime:11.7.0

#Configure Pip to Ignore SSL Verification in Dockerfile
# Create pip configuration file to ignore SSL verification
#Option2
#RUN mkdir ~/.pip
#RUN echo "[global]\ntrusted-host = pip.astronomer.io\nindex-url = https://pip.astronomer.io/v2/pip/\ndisable-pip-version-check = true\nno-cache-dir = true" > ~/.pip/pip.conf

# Install Python dependencies
#RUN pip install astro-run-dag

#Option3
#Install Python dependencies from an alternative index
#RUN pip install --index-url https://pypi.org/simple/ --no-cache-dir astro-run-dag

#option 4
#FROM quay.io/astronomer/astro-runtime:11.7.0

# Create pip configuration file to ignore SSL verification
#RUN mkdir -p /root/.config/pip
#RUN echo "[global]\ntrusted-host = pip.astronomer.io\nindex-url = https://pip.astronomer.io/v2/\ndisable-pip-version-check = true\nno-cache-dir = true" > /root/.config/pip/pip.conf

# Install Python dependencies
#RUN pip install astro-run-dag
#Option 5 
##RUN pip config set global.trusted-host pip.astronomer.io
#RUN pip config set global.index-url https://pip.astronomer.io/v2/pip/
#RUN pip config set global.cert /etc/ssl/certs/ca-certificates.crt

# Install Python dependencies
#RUN pip install --trusted-host pip.astronomer.io --index-url https://pip.astronomer.io/v2/pip/ --no-cache-dir astro-run-dag

#Option 6
FROM quay.io/astronomer/astro-runtime:11.7.0

# Set environment variables to disable SSL verification
ENV PIP_TRUSTED_HOST=pip.astronomer.io
ENV PIP_INDEX_URL=https://pip.astronomer.io/v2/
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_NO_CACHE_DIR=1

# Create pip configuration file to ignore SSL verification
#RUN #mkdir -p /astro_config/.config/pip && \
#RUN echo "[global]\ntrusted-host = pip.astronomer.io\nindex-url = https://pip.astronomer.io/v2/\ndisable-pip-version-check = true\nno-cache-dir = true" > /astro_config/.config/pip/pip.conf
RUN mkdir -p /tmp/.config/pip && \
    echo "[global]\ntrusted-host = pip.astronomer.io\nindex-url = https://pip.astronomer.io/v2/\ndisable-pip-version-check = true\nno-cache-dir = true" > /tmp/.config/pip/pip.conf


# Copy the requirements file
COPY requirements.txt .

# Install Python dependencies with SSL verification disabled
RUN python -m pip install --trusted-host pip.astronomer.io -r requirements.txt


