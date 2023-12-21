import Foundation
import SwiftUI

extension Color
{
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme
{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

//how to add a new color theme
// select a color or add a named color from files.
//add here the new colors and change the static let theme = ColorTheme() to ColorTheme2() in 6th line.
struct ColorTheme2
{
    let accent = Color("")
    let background = Color("")
    let green = Color("")
    let red = Color("")
    let secondaryText = Color("")
}


struct LaunchTheme
{
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}

