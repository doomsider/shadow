#!/bin/bash

FILES=./*

for file in ./*
do
	if $(echo $file | grep -q .dtsd)
	then
		dos2unix $file
	fi
done