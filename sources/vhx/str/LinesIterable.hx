package vhx.str;

import haxe.io.Input;

using vhx.io.InputTools;


@:forward @:transitive

abstract LinesIterable( Iterable< String > ) from Iterable< String > to Iterable< String > {

  @:from public static inline function fromIterable( value: Iterable< String > ): LinesIterable

    return value;

  @:from public static inline function fromString( value: String ): LinesIterable

    return value.split( '\n' );

  @:from public static inline function fromInput( value: Input ): LinesIterable

    return value.forLine();

}
