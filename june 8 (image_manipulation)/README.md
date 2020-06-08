# Production Assignment: Image Manipulation
Since this assignment was fairly open-ended, I decided to use what we learned about displaying images with Processing to implement an idea I had during the [last producting assignment](https://github.com/mike-leo-k/intro-to-im/blob/master/june%207/), which concerned data visualization.

This project looks at police killings in the United States, specifically those where the victim is a black person and the officers responsible were not charged for the crime. I chose to represent this data because it is particularly relevant given the rising prominence of the Black Lives Matter movement, and because I wanted data appropriate to be represented over an image.

The data on police killings from each state was obtained from [Mapping Police Violence](https://mappingpoliceviolence.org/states), which compiles information regarding all fatal encounters wil law enforcement. I downloaded the information on killings by state, where the perpetrators were uncharged in the form of a crosstab. Converting it to CSV format gave me:
<p align="center">
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%208%20(image_manipulation)/pictures/police%20killings.jpg">
</p>

Then, inputting values of each states' latitude and longitude from [this website](https://www.latlong.net/category/states-236-14.html), and removing any information irrelevant to the visualization:
<p align="center">
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%208%20(image_manipulation)/pictures/state_coord.jpg">
</p>

Then, using a for() loop, with pushMatrix() at the beginning followed by an incremental downward translation (using translat(0, i), i += 15) and a subsequent popMatric(), I repeated the sine graph throughout the screen:
<p align="center">
  <br>
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%207/pictures/trans_3.png">
</p>

Now came the tricky part. Unable to find a way to accurately automate the counting of the number of occurrences by state, I opted to input the number of occurrences manually, by using Excel to count the instances in each case:
<p align="center">
  <br>
  <img width="500" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%208%20(image_manipulation)/pictures/occurences.jpg">
</p>

Using for() loops, I was able to read the values from this information table into a 2D array. Using a second for() loop, I read each row of the array and used its values to draw an ellipse. The coordinates of the ellipse were based on the states' coordinates (mapped to the image I used), while the size of the ellipse was based on the number of occurrences in each state. I also made the alpha value of each ellipse's fill color depend on the number of occurrences.

### Final Render
<p align="center">
  <img width="1000" src="https://github.com/mike-leo-k/intro-to-im/blob/master/june%208%20(image_manipulation)/pictures/final_output.png">
</p>

### Challenges/Discoveries
* 
