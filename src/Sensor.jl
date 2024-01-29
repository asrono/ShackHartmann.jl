mutable struct Sensor
    aperture::Aperture
    screen::Screen
end

Sensor() = Sensor(Aperture(), Screen())

function example_sensor()
    s = Sensor(
        Aperture(
            [SubAperture(
                (0.,0.),
                150e-6,
                150e-6,
                [],
                [],
                Matrix{Complex}([;;])
            )],
            200e-6,
            150e-6,
            [],
            [],
            Matrix{Complex}([;;])
        ),
        Screen(
            [],
            [],
            Matrix{Complex}([;;])
        )
    )
    return s
end