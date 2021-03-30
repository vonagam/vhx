package vhx.iter.impl;

import vhx.iter.SimpleIterator;


class ByOneIterable< T > {

  final value: Null< T >;

  final getNext: ( value: T ) -> Null< T >;


  public inline function new( value: Null< T >, getNext: ( value: T ) -> Null< T > ) {

    this.value = value;

    this.getNext = getNext;

  }


  public inline function iterator()

    return new ByOneIterator( value, getNext );

}


class ByOneIterator< T > extends SimpleIterator< T > {

  var current: Null< T >;

  var started = false;

  final getNext: ( value: T ) -> Null< T >;


  public function new( current: Null< T >, getNext: ( value: T ) -> Null< T > ) {

    this.current = current;

    this.getNext = getNext;

  }


  function step() {

    current = started && current != null ? getNext( current ) : current;

    started = true;

    has = current != null;

    if ( ! has ) return;

    value = current;

  }

}
