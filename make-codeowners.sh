#!/bin/bash

# This script generates documentation-specific CODEOWNERS content for any arguments passed.

CONTENT_LENGTH=43

usage(){
  echo "Usage: ${0} INTEGRATION [INTEGRATIONS]..."
  exit 1
}

markdown_string(){
local STRING_LENGTH=$(echo /${INTEGRATION}/*.md | wc -m)
local NUMBER_OF_SPACES=$((CONTENT_LENGTH-STRING_LENGTH))
local SPACES=$(head -c "${NUMBER_OF_SPACES}" < /dev/zero | tr '\0' '\040')
echo "/${INTEGRATION}/*.md${SPACES}@DataDog/documentation"
}

manifest_string(){
local STRING_LENGTH=$(echo /${INTEGRATION}/manifest.json | wc -m)
local NUMBER_OF_SPACES=$((CONTENT_LENGTH-STRING_LENGTH))
local SPACES=$(head -c "${NUMBER_OF_SPACES}" < /dev/zero | tr '\0' '\040')
echo "/${INTEGRATION}/manifest.json${SPACES}@DataDog/documentation"
}

assets_string(){
local STRING_LENGTH=$(echo /${INTEGRATION}/assets/ | wc -m)
local NUMBER_OF_SPACES=$((CONTENT_LENGTH-STRING_LENGTH))
local SPACES=$(head -c "${NUMBER_OF_SPACES}" < /dev/zero | tr '\0' '\040')
echo "/${INTEGRATION}/assets/${SPACES}@DataDog/documentation"
}

if [[ "${#}" -lt 1 ]]
then
  usage
fi

for INTEGRATION in "${@}" 
do
  MARKDOWN_STRING=$(markdown_string)
  MANIFEST_STRING=$(manifest_string)
  ASSETS_STRING=$(assets_string)
  echo "Creating codeowners content for: ${INTEGRATION}"
  echo "${MARKDOWN_STRING}"
  echo "${MANIFEST_STRING}"
  echo "${ASSETS_STRING}"
done                      
                             
exit 0