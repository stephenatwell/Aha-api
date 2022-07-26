

#rem usage
# bulkMove.sh apiKey feature#
#curl -H "Authorization: Bearer $1" https://company.aha.io/api/v1/features/$2

requirements=$(curl -H "Authorization: Bearer $1" https://armory.aha.io/api/v1/features/$2/requirements| jq --compact-output '.requirements[]|{"id":.id,"integration_id_value":.integration_fields[]|select(. | .name=="id")|.value,"integration_entity_value":.integration_fields[]|select(. | .name=="aha::remote_entity")|.value}')
#new_requirements=$(curl -H "Authorization: Bearer $1" https://armory.aha.io/api/v1/features/$2/requirements| jq --compact-output '.requirements[].integration_fields[].id="7123281128977784514"')
echo ${requirements}

sample='[{"name":"foo"},{"name":"bar"}]'
for requirement in ${requirements}; do
     id=$(echo ${requirement}| jq -r '.id')
     #integration_id_value=$(echo ${requirement}| jq -r '.integration_id_value')
     #integration_entity_value=$(echo ${requirement}| jq -r '.integration_entity_value')
     
     #this one works
     set -x
    # curl "https://company.aha.io/api/v1/requirements/$id/integrations/7123281128977784514/fields" -d \
    # "{\"integration_field\":{\"name\":\"id\",\"value\":\"$integration_id_value\"}}" \
    # -X POST   -H "Authorization: Bearer $1"    -H "Content-Type: application/json"     -H "Accept: application/json"
    # curl "https://company.aha.io/api/v1/requirements/$id/integrations/7123281128977784514/fields" -d \
    # "{\"integration_field\":{\"name\":\"aha::remote_entity\",\"value\":\"$integration_entity_value\"}}" \
    # -X POST   -H "Authorization: Bearer $1"    -H "Content-Type: application/json"     -H "Accept: application/json"

    curl "https://company.aha.io/api/v1/requirements/$id" -d '' -X DELETE \
	-H "Authorization: Bearer $1" \
	-H "Content-Type: application/json" \
	-H "Accept: application/json"
done
