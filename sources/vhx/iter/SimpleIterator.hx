package vhx.iter;


abstract class SimpleIterator< T > {

  var has: Bool = true;

  var value: T;

  var updated: Bool = false;


  abstract function step(): Void;


  public function hasNext() {

    update();

    return has;

  }

  public function next(): T {

    update();

    updated = false;

    return value;

  }


  function update() {

    if ( updated || ! has ) return;

    updated = true;

    step();

  }

}
