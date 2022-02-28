# Jalaali Swift

A few Swift functions for converting Jalaali (Jalali, Persian, Khayyami, Khorshidi, Shamsi) and Gregorian calendar systems to each other.

## About

Jalali calendar is a solar calendar that was used in Persia, variants of which today are still in use in Iran as well as Afghanistan. [Read more on Wikipedia](http://en.wikipedia.org/wiki/Jalali_calendar) or see [Calendar Converter](http://www.fourmilab.ch/documents/calendar/).

Calendar conversion is based on the [algorithm provided by Kazimierz M. Borkowski](http://www.astro.uni.torun.pl/~kb/Papers/EMP/PersianC-EMP.htm) and has a very good performance.

## Install

Use [Carthage](https://github.com/Carthage/Carthage) to build and install.

## API

### Converts a Gregorian date to Jalaali
```swift
func toJalaali(gy: GregorianYear, _ gm: GregorianMonth, _ gd: GregorianDay) -> JalaaliDate
```

### Converts a Jalaali date to Gregorian
```swift
func toGregorian(jy: JalaaliYear, _ jm: JalaaliMonth, _ jd: JalaaliDay) -> GregorianDate
```


### Checks whether a Jalaali date is valid or not
```swift
func isValidJalaaliDate(jy: JalaaliYear, _ jm: JalaaliMonth, _ jd: JalaaliDay) -> Bool
```

### Is this a leap year or not?
```swift
func isLeapJalaaliYear(jy: JalaaliYear) -> Bool {
```

### Number of days in a given month in a Jalaali year
```swift
func lastDayOfJalaaliMonth(jy: JalaaliYear, _ jm: JalaaliMonth) -> JalaaliDay
```

### A tuple for a Jalaali date
```swift
typealias JalaaliDate = (year: JalaaliYear, month: JalaaliMonth, day: JalaaliDay)
```

### A tuple for a Gregorian date
```swift
typealias GregorianDate = (year: GregorianYear, month: GregorianMonth, day: GregorianDay)
```

### An Int representing a Jalaali year
```swift
typealias JalaaliYear = Int
```

### An Int representing a Jalaali month (1-based)
```swift
typealias JalaaliMonth = Int
```

### An Int representing a Jalaali day
```swift
typealias JalaaliDay = Int
```

### An Int representing a Gregorian year
```swift
typealias GregorianYear = Int
```

### An Int representing a Gregorian month (1-based)
```swift
typealias GregorianMonth = Int
```

### An Int representing a Gregorian day
```swift
typealias GregorianDay = Int
```

### An Int representing a Julian Day Number
```swift
typealias JulianDayNumber = Int
```

---

## License

MIT
