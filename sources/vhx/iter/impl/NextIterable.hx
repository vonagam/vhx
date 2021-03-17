package vhx.iter.impl;

import vhx.iter.SimpleIterator;


class NextIterable< T > {

  final value: Null< T >;

  final next: ( value: T ) -> Null< T >;


  public inline function new( value: Null< T >, next: ( value: T ) -> Null< T > ) {

    this.value = value;

    this.next = next;

  }


  public inline function iterator()

    return new NextIterator( value, next );

}


class NextIterator< T > extends SimpleIterator< T > {

  var current: Null< T >;

  var started = false;

  final map: ( value: T ) -> Null< T >;


  public function new( current: Null< T >, map: ( value: T ) -> Null< T > ) {

    this.current = current;

    this.map = map;

  }


  function step() {

    current = started && current != null ? map( current ) : current;

    started = true;

    has = current != null;

    if ( ! has ) return;

    value = current;

  }

}
