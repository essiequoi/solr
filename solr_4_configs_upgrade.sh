#! /bin/bash

#Deprecated fieldTypes
fieldTypes[0]='LatLonType'
fieldTypes[1]='GeoHashField'
fieldTypes[2]='SpatialVectorFieldType'
fieldTypes[3]='SpatialTermQueryPrefixTreeFieldType'
fieldTypes[4]='EnumField'
fieldTypes[5]='TrieDateField'
fieldTypes[6]='TrieDoubleField'
fieldTypes[7]='TrieFloatField'
fieldTypes[8]='TrieIntField'
fieldTypes[9]='TrieLongField'
fieldTypes[10]='TrieField'

#DocValues fieldTypes
dvTypes[0]='StrField'
dvTypes[1]='UUIDField'
dvTypes[2]='EnumField'
dvTypes[3]='PointField'
dvTypes[4]='BoolField'
dvTypes[5]='DatePointField'
dvTypes[6]='DoublePointField'
dvTypes[7]='FloatPointField'
dvTypes[8]='IntPointField'
dvTypes[9]='LongPointField'
dvTypes[10]='TrieDateField'
dvTypes[11]='TrieDoubleField'
dvTypes[12]='TrieFloatField'
dvTypes[13]='TrieIntField'
dvTypes[14]='TrieLongField'
dvTypes[15]='TrieField'

#take schema as input
#SCHEMA=$1

#take directory as input
DIR=$1

f=$((${#DIR}-1))
echo "${DIR:$f:1}"
VAL=${DIR:$f:1}
#if directory ends in forward slash...then append *.xml
#otherwise append /*.xml
if [ "/" == $VAL ]
	then
	DIRX=$1'*.xml'
	DIR=$1'*'
else
	DIRX=$1'/*.xml'
	DIR=$1'/*'
fi

echo $DIR

#iterate through the fieldTypes array and look for occurrence of each fieldType in the schema




echo "!!!!!FIELD DEPRECATIONS!!!!!" >> field_deprecations.txt
for file in $(find $DIR -name '*schema.xml');
do 
	filename="${file##*/}"
	for i in "${fieldTypes[@]}"
	do
		echo '*****'${filename} >> field_deprecations.txt
		echo ${i} >> field_deprecations.txt
		#xmllint --noout --xpath "/schema/fieldType[@class='solr.${i}']" ${file} 
		xpath ${file} "/schema/fieldType[@class='solr.${i}']" >> field_deprecations.txt
		echo '' >> field_deprecations.txt
		echo '--------' >> field_deprecations.txt
	done
done


#docValues fieldTypes
echo "!!!!!DOCVALUES TYPES!!!!!" >> docValues.txt
for file in $(find $DIR -name '*schema.xml');
do 
	filename="${file##*/}"
	for i in "${dvTypes[@]}"
	do
		echo '*****'${filename} >> docValues.txt
		echo ${i} >> docValues.txt
		#xmllint --noout --xpath "/schema/fieldType[@class='solr.${i}']" ${file} 
		xpath ${file} "/schema/fieldType[@class='solr.${i}']" >> docValues.txt
		echo '---------' >> docValues.txt
	done 
done 
