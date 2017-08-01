Object subclass: BKKEncryptor[
    init[

    ]
    encrypt: input[
        ^input
    ]
]
BKKEncryptor class extend[
    new[
        | r |
        r := super new.
        r init.
        ^r
    ]
]