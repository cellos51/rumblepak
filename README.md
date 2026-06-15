# RumblePak
## A tool for easily adding customizable controller haptic feedback.
<p align="center">
  <img src="https://raw.githubusercontent.com/cellos51/rumblepak/refs/heads/main/addons/rumblepak/icons/logo.svg" />
</p>

## About

I was a bit disappointed by Godot's lack of multiple channels when it comes to controller vibration.
Any change to vibration would override the last setting, so I decided to make a plugin to fix that!

### Features

- Multiple independent rumble channels
- Curve-based haptic presets
- Bus-based intensity control
- Global rumble scaling
- Easy integration with existing projects

<table>
  <tr>
    <td width="480">
      <img src="https://github.com/cellos51/rumblepak/blob/main/rumble_preset.png" alt="Logo" width="480">
    </td>
    <td>
      <h3>RumblePreset</h3>
      <p>
        With RumblePresets, you can easily create controller haptic profiles for any event needed in your game through Godot's curve editor.
      </p>
      <p>
        Changing the bus name allows you to manually control the intensity of all haptic events running on it by setting the global intensity of that bus in code.
      </p>
    </td>
  </tr>
</table>

## How to use

Simply create a **RumblePreset** resource, configure it, and attach it to a node. 

Then, in your script, just run
```gdscript
RumblePak.add_rumble(rumble_preset)

RumblePak.set_bus_strength(0.5, &"explosion")
```

To change the strength of a specific bus, call
```gdscript
func set_bus_strength(0.5, &"explosion")

func set_bus_strength(0.7, &"master")
```
Changing `"master"` will affect the global rumble intensity.

## Installation
1. Click on the green "Code" button and select "Download ZIP".
2. Extract the `addons` folder into the root of your Godot project.
3. Enable the plugin in your Godot project settings.

Tested with Godot 4.6
