package vhx.funcs;


@:forward @:callable @:transitive

abstract Supplier< T >( () -> T ) from () -> T to () -> T {

  @:from static inline function fromValue< T >( value: T ): Supplier< T >

    return () -> ( value );

}
