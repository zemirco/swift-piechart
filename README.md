
# Swift Piechart

Piechart library for iOS written in Swift.

## Usage

```swift
var total: CGFloat = 20

var error = Piechart.Slice()
error.value = 4 / total
error.color = UIColor.magentaColor()
error.text = "Error"

var zero = Piechart.Slice()
zero.value = 6 / total
zero.color = UIColor.blueColor()
zero.text = "Zero"

var win = Piechart.Slice()
win.value = 10 / total
win.color = UIColor.orangeColor()
win.text = "Winner"

var piechart = Piechart()
piechart.title = "Service"
piechart.activeSlice = 0
piechart.slices = [error, zero, win]
```

![piechart demo](https://raw.githubusercontent.com/zemirco/swift-piechart/master/screenshot.png)

## Properties

- `title`: String - Piechart title for center top position.
- `subtitle`: String - Piechart subtitle below title.
- `info`: String - Some additional information below subtitle.
- `slices`: [Slice] - Data for Piechart. Each `slice` has properties:
  - `color`: UIColor - Slice color
  - `value`: CGFloat - Slice percentage value from 0 to 1.
  - `text`: String - Slice text / description
- `radius`: Radius
  - `inner`: CGFloat = `40` - Radius for inner circle.
  - `outer`: CGFLoat = `60` - Radius for outer circle.
- `activeSlice`: Int = `0` - Index for highlighted slice.

## Delegates

```swift
func setSubtitle(slice: Piechart.Slice) -> String
```

Set subtitle label text for given `slice`.

```swift
func setInfo(slice: Piechart.Slice) -> String
```

Set info label text for given `slice`.

## License

MIT
