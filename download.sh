#!/bin/bash
domain_name="${1}"
search=${2}
replace=${3}
tmp_dir="/tmp/tmp_${domain_name}"
rm -rf ${tmp_dir}
wget      --recursive      --no-clobber      --page-requisites      --html-extension      --convert-links      --restrict-file-names=windows      --domains ${domain_name}      --no-parent    --directory-prefix=${tmp_dir}      http://${domain_name}
git checkout gh-pages
rm -rf ${domain_name}
cp -rf ${tmp_dir}/${domain_name} .
rm -rf ${tmp_dir}
find ${domain_name} -type f | xargs sed -i "s?$search?$replace?Ig"
git add ${domain_name}
git commit -m "${domain_name}"
git push origin gh-pages
