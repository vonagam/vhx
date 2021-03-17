package vhx.funcs;


@:forward @:callable @:transitive

@:using( vhx.funcs.Predicate )

abstract Predicate< T >( ( value: T ) -> Bool ) from ( value: T ) -> Bool to ( value: T ) -> Bool {

  @:from static inline function fromFunc< T >( predicate: () -> Bool ): Predicate< T >

    return ( _ ) -> predicate();

  @:from static inline function fromValue< T >( value: T ): Predicate< T >

    return ( input ) -> input == value;

  @:from static inline function fromBool< T >( value: Bool ): Predicate< T >

    return ( _ ) -> ( value );

  @:from static inline function fromMap< T >( map: Map< T, Bool > ): Predicate< T >

    return ( input ) -> ( map[ input ] );

  @:from static inline function fromArray< T >( array: Array< T > ): Predicate< T >

    return ( input ) -> array.indexOf( input ) != -1;


  public static inline function negate< T >( predicate: Predicate< T > ): Predicate< T >

    return ( value ) -> ! predicate( value );

}
