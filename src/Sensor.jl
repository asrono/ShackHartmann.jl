mutable struct Sensor
    aperture::Aperture
    screen::Screen
end

Sensor() = Sensor(Aperture(), Screen())

function example_sensor()
    s = Sensor(
        Aperture(
            [
                SubAperture(
                    (-100e-6, 0.),
                    [],
                    [],
                    Matrix{Complex}([;;])
                )
                ,
                SubAperture(
                    (100e-6,0.),
                    [],
                    [],
                    Matrix{Complex}([;;])
                )
            ],
            400e-6,
            150e-6,
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