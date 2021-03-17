package vhx.io;

import haxe.io.Input;

import vhx.iter.SimpleIterator;


class InputTools {

  public static function use< T: Input, R >( input: T, use: ( input: T ) -> R ) {

    try {

      final result = use( input );

      input.close();

      return result;

    } catch ( error ) {

      input.close();

      throw error;

    }

  }


  public static inline function forLine( input: Input )

    return { iterator: () -> new InputLinesIterator( input ) };

}


class InputLinesIterator extends SimpleIterator< String > {

  final input: Input;


  public function new( input: Input ) {

    this.input = input;

  }


  function step() {

    try {

      value = input.readLine();

      has = true;

    } catch ( error: haxe.io.Eof ) {

      value = '';

      has = false;

    }

  }

}
