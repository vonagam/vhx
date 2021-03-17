package vhx.funcs;


@:forward @:callable @:transitive

abstract Mapper< T, R >( ( value: T ) -> R ) from ( value: T ) -> R to ( value: T ) -> R {

  @:from static inline function fromFunc< T, R >( mapper: () -> R ): Mapper< T, R >

    return ( _ ) -> mapper();

  @:from static inline function fromMap< T, R >( map: Map< T, R > ): Mapper< T, R >

    return ( input ) -> ( map[ input ] );

  @:from static inline function fromValue< T, R >( value: R ): Mapper< T, R >

    return ( _ ) -> ( value );

}
