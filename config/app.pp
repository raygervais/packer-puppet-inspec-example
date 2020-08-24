 class app { 
    user { 'rgervais':
      ensure     => present,
      managehome => true,
      home       => '/home/rgervais'
    }
}
