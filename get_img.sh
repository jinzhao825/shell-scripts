#!/bin/bash
i=1
cat page1.txt|while read LINE
do
	img_num=$LINE
	page_url=http://tibet.prm.ox.ac.uk/photo_$img_num.html
	img_url=http://tibet.prm.ox.ac.uk/photos/opt/400/$img_num-O.jpg
	img_magnify=http://tibet.prm.ox.ac.uk/zoom.php?a=$img_num

	#Getting image's name and downloading every image
	curl $page_url > tmp.txt
	img_name=$(grep "photos/opt/400" tmp.txt |awk -F "\"" '{print $4}')
	wget $img_url -O $i-"$img_name".jpg
	echo $img_magnify

	#Getting image information
	grep detailSection tmp.txt > infotmp.txt
	sed -i ".ori1" 's/ <div class="detailSection"><h2>//g' infotmp.txt
	sed -i '.ori2' 's/<\/h2> <p>/:/g' infotmp.txt
	sed -i '.ori3' 's/<\/p><\/div>//g' infotmp.txt 
	sed -i '.ori4' 's/<SPAN>//g' infotmp.txt 
	sed -i '.ori5' 's/<\/SPAN>//g' infotmp.txt 
	sed -i '.ori6' 's/<BR>//g' infotmp.txt 
	sed -i '.ori71' 's/<span class="glossaryLink"><a href="biography_[0-9]html" title="See entry in biography">//g' infotmp.txt 
	sed -i '.ori72' 's/<span class="glossaryLink"><a href="biography_[0-9][0-9].html" title="See entry in biography">//g' infotmp.txt 
	sed -i '.ori73' 's/<span class="glossaryLink"><a href="biography_[0-9][0-9][0-9].html" title="See entry in biography">//g' infotmp.txt 
	sed -i '.ori8' 's/<\/a><\/span>//g' infotmp.txt 
	sed -i '.ori9' 's/&gt;/>/g' infotmp.txt
	sed -i '.ori10' 's/&quot;/"/g' infotmp.txt
	cp infotmp.txt $i-"$img_name".txt

	i=$(expr $i + 1)	
done
