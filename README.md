# imgcmp

An attempt to ensure the differences between a source and a derived image used in the journal can be calculated and be
used to detect errors.

## requirements

* [ImageMagick](https://imagemagick.org)

## usage

    ./diff.sh
    
## example output

```bash
this compares a png and a jpg image derived from a tiff image using ImageMagick.
the comparison will fail with a non-zero return code if the two images are not 'similar'.
the magic number that is emitted are the number of pixels considered 'different'.
the degree of similarity/difference can be controlled using the '-fuzz' parameter.

'pae' is 'Peak Absolute Error (normalised).
the pae value will tell us the fuzz factor needed for the two to be similar.

'ae' is the 'Absolute Error' count.
the number it emits are the number of pixels that are not identical
-----------
png with jpg (pae, no fuzz)
- 23644 (0.360784)
- rc: 1 (failed)
- wrote png--jpg--pae.png
-----------
png with jpg (ae, no fuzz)
- 461072
- rc: 1 (failed)
- wrote png--jpg--ae.png
-----------
png with jpg (ae, fuzz 1%)
- 220636
- rc: 1 (failed)
- wrote png--jpg--fuzz01.png
-----------
png with jpg (ae, fuzz 5%)
- 18088
- rc: 1 (failed)
- wrote png--jpg--fuzz05.png
-----------
png with jpg (ae, fuzz 10%)
- 863
- rc: 1 (failed)
- wrote png--jpg--fuzz10.png
-----------
png with jpg (ae, fuzz 15%)
- 130
- rc: 1 (failed)
- wrote png--jpg--fuzz15.png
-----------
png with jpg (ae, fuzz 20%)
- 17
- rc: 1 (failed)
- wrote png--jpg--fuzz20.png
-----------
png with jpg (ae, fuzz 25%)
- 4
- rc: 1 (failed)
- wrote png--jpg--fuzz25.png
-----------
png with jpg (ae, fuzz 36%)
- 0
- rc: 0 (passed)
- wrote png--jpg--fuzz36.png

the pae value indicated the fuzz factor required to achieve zero differences (36%)
now lets compare the default.jpg with bad.jpg

-----------
(good) jpg with (bad) jpg (pae, no fuzz)
- 65535 (1)
- rc: 1 (failed)
- wrote jpg--bad-jpg--mepp.png
-----------
(good) jpg with (bad) jpg (ae, no fuzz)
- 2.20205e+06
- rc: 1 (failed)
- wrote jpg--bad-jpg--pae.png

the pae value here is 1 (100% different)
lets fuzz it a little bit and see how the total number of different pixels goes down

-----------
(good) jpg with (bad) jpg (ae, fuzz 10%)
- 986852
- rc: 1 (failed)
- wrote jpg--bad-jpg--fuzz10.png
-----------
(good) jpg with (bad) jpg (ae, fuzz 20%)
- 368569
- rc: 1 (failed)
- wrote jpg--bad-jpg--fuzz20.png
-----------
(good) jpg with (bad) jpg (ae, fuzz 30%)
- 129009
- rc: 1 (failed)
- wrote jpg--bad-jpg--fuzz30.png
-----------
(good) jpg with (bad) jpg (ae, fuzz 40%)
- 81557
- rc: 1 (failed)
- wrote jpg--bad-jpg--fuzz40.png
-----------
(good) jpg with (bad) jpg (ae, fuzz 50%)
- 72130
- rc: 1 (failed)
- wrote jpg--bad-jpg--fuzz50.png
-----------
(good) jpg with (bad) jpg (ae, fuzz 75%)
- 59468
- rc: 1 (failed)
- wrote jpg--bad-jpg--fuzz75.png
-----------
(good) jpg with (bad) jpg (ae, fuzz 99%)
- 643
- rc: 1 (failed)
- wrote jpg--bad-jpg--fuzz99.png
```
