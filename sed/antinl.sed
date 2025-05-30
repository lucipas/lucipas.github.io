#!/bin/sh -E

# take in all the file
:a
$!N
$!ba

s/[\n\t]//g
s/>\s+/>/g
