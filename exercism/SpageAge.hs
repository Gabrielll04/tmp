data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

ageOn :: Planet -> Float -> Float
ageOn Earth seconds = (seconds / 86400) / 365.25
ageOn Mercury seconds = (seconds / 86400) / 87.969257175
ageOn Venus seconds = (seconds / 86400) / 224.700799215
ageOn Mars seconds = (seconds / 86400) / 686.96797095
ageOn Jupiter seconds = (seconds / 86400) / 4332.82012875
ageOn Saturn seconds = (seconds / 86400) / 10755.6986445
ageOn Uranus seconds = (seconds / 86400) / 30687.1530015
ageOn Neptune seconds = (seconds / 86400) / 60190.02963
