=== BubblePaint V0.2 ===

Displays circles that have the average colour of the area they cover.  When you touch a circle it splits into 4 smaller circles. This slowly reveals the image

Release Notes (0.2):

Changes:
- Takes in a 512x512 BMP and uses that to determine the colour of new bubbles based on the average of the area covered by the bubble
- Can take a sprite and will convert it to a 512x512 BMP

Issues:
- Math seems incorrect for determining what pixels to use to get average. Only noticable on the edge of the image.
- Doesn't test against image bounds when grabbing pixels
- Test for perfect colour (bubble made up of only one colour) doesn't look correct.  Probably due to the bad math for location.
- SLOW!

Release Notes (0.1):
First release,

Displays bubbles and pops them.  Colours are random.

Issues:
- Bubble split animation should be improved
- Colour generation should be based on average of sub-bubbles