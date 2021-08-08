#!/bin/bash

for package in $(ls | grep -E ".*tar.gz");do
	curl -v -u admin:raflman -X POST "http://jupiter:8081/service/rest/v1/components?repository=pypi" -F "pypi.asset=@${package};type=application/gzip"
done



for package in $(ls | grep -E ".*egg");do
        curl -v -u admin:raflman -X POST "http://jupiter:8081/service/rest/v1/components?repository=pypi" -F "pypi.asset=@${package}"
done

for package in $(ls | grep -E ".*tgz");do
        curl -v -u admin:raflman -X POST "http://jupiter:8081/service/rest/v1/components?repository=pypi" -F "pypi.asset=@${package};type=application/x-compressed-tar"
done



for package in $(ls | grep -E ".*whl");do
        curl -v -u admin:raflman -X POST "http://jupiter:8081/service/rest/v1/components?repository=pypi" -F "pypi.asset=@${package}"
done


for package in $(ls | grep -E ".*bz2");do
        curl -v -u admin:raflman -X POST "http://jupiter:8081/service/rest/v1/components?repository=pypi" -F "pypi.asset=@${package};type=application/x-bzip"
done


for package in $(ls | grep -E ".*zip");do
        curl -v -u admin:raflman -X POST "http://jupiter:8081/service/rest/v1/components?repository=pypi" -F "pypi.asset=@${package};type=application/zip"
done
