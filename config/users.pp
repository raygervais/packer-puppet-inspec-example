user { "dev":
    ensure     => present,
    managehome => true,
    home       => "/home/dev"
}

user { "qat":
    ensure     => present,
    managehome => true,
    home       => "/home/qat"
}

user { "uat":
    ensure     => present,
    managehome => true,
    home       => "/home/uat"
}

