
# DesignSystem

  This package is the implementation of design system. It implements the design elements and the other packages uses these design elements. It also exposes some constants to standardize things like colors and gradients. This packes uses its own resource assests.

## Resource Assets

This package uses *Media.xcassets* file as the assets holder file. The resources in the file are;

 - Color: ApplicationBackground
 - Color: ApplicationPrimary
 - Color: ApplicationSecondary
 - Color: TextOnPrimary
 - Color: TextPrimary
 - Color: TextSecondary

All these colors are defined with dark/light mode.

## Constants

Constants are defined as structures. There are both public constants that are available for the usage on other packages and internal constants that are only used in this package.

### Public Structs

 - TextColor(.primary || .secondary || .onPrimary)
 - ApplicationColor(.primary || .secondary)
 - ApplicationBackgroundColor(.backgroundColor)
 - ApplicationGradient(.secondaryToPrimary)
 
### Internal Structs

 - ApplicationFont(.headline1 || .headline2 || button || body || caption)

## UI Elements

These are the implementations of the UI elements that are meant to be used in other projects as buildin blocks

 - AnimatedButton
 - BodyText
 - Caption
 - Constants
 - CustomMessage
 - Headline1
 - Headline2

## Further Discussion

### Insets and Paddings
I believe design system should be also controlling the padding and the insets for the application. Therefore there needs to be default padding values on the controls and different predefined inset values defined in the design system. For the sake of simpilicity in the project I choose to omit those and implement those in the screens. However larger projects might need a different approach. 
