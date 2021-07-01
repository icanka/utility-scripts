import subprocess
import os
bashCommand = "ls -l"
process = subprocess.run(bashCommand.split(), text=True, stdout=subprocess.PIPE, check=True)

for line in process.stdout.split('\n'):
    print(line)

directory = r'/home/izzetcan/PycharmProjects/nexus-upload/packages/Packages'
count = 0
for entry in os.scandir(directory):
    count += 1
    bashCommand = f"curl -v -u admin:armerkom --upload-file {entry.name} http://jenkins.local:8081/repository/test-yum/gamsys/{entry.name}"
    print(bashCommand)
    process = subprocess.run(bashCommand.split(), text=True, stdout=subprocess.PIPE, check=True)

    # for line in process.stdout.split('\n'):
    #     print(line)
    if count == 1:
        break




# curl -v -u admin:admin123 --upload-file cpaste-1.0.0-3.el8.x86_64.rpm http://nexus:8081/repository/test-yum/gamsys/cpaste-1.0.0-3.el8.x86_64.rpm