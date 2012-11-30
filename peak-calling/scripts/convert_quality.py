import sys, subprocess


def convert_quality_score(solid_filename, illum_filename):
    solid_file = open(solid_filename, 'r')
    illum_file = open(illum_filename, 'w')
    line_number = 0
    line = solid_file.readline()
    while(line):
        if (line_number % 4 == 3): #get the line with quality scores
            score_array = line.split()
            illum_array = []
            for solid_score in score_array:
                illum_score = chr(int(solid_score) + 64)
                illum_array.append(illum_score)
            illum_file.write("%s\n" % ''.join(illum_array))
        else:
            illum_file.write(line)

        line_number += 1
        line = solid_file.readline()

    solid_file.close()
    illum_file.close()

if (len(sys.argv) > 2):
    solid_filename = sys.argv[1]
    illum_filename = sys.argv[2]
    convert_quality_score(solid_filename, illum_filename)
else:
    print "Usage: python convert_quality.py [SOLID filename]"
