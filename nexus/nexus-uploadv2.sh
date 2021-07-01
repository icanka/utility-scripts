#!/bin/bash
#cd ./packages/Packages || exit

curlCommand="curl -v -u admin:armerkom --upload-file "
path_to_files=$1
file_extension=$2
repository=$3


function print_if_success {
	if [[ $? -eq 0 ]];then
		printf "%25s\n" "SUCCESS"
		return 0
	else
		return 3
	fi
}

function print_help_message() {
  echo "Please provide all the required arguments correctly."
  echo "Usage: plugin-upload.sh /path/to/dir/ file_extension url_to_nexus_repository"
  echo "e.g. './plugin-upload.sh /opt/advent/repos/Packages/ rpm https://nexus/repository/centos-repo/'"
}



if [[ -n ${path_to_files} && -d ${path_to_files} ]]; then
  if [[ -n ${file_extension} ]]; then
      if [[ -n ${repository} ]]; then


        cd "${path_to_files}" || exit
        for filename in *."${2}";
        do

          echo ${filename}

          curlCommand="curl -k -v -u admin:armerkom --upload-file ${filename} ${repository}/${filename}"
          ${curlCommand}
          print_if_success
          if [[ $? -ne 0 ]];then
            exit
          fi
        done



      else
        echo "Please provide the root repositoryl url"
        print_help_message
      fi
  else
    echo "Please provide a file extension."
    print_help_message
  fi
else
  echo "Please provide a valid path in which the ${file_extension} files reside"
  print_help_message
fi
