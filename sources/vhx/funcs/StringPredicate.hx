package vhx.funcs;


@:forward @:callable @:transitive

abstract StringPredicate( ( value: String ) -> Bool ) from ( value: String ) -> Bool to ( value: String ) -> Bool {

  @:from static inline function fromFunc( predicate: () -> Bool ): StringPredicate

    return ( _ ) -> predicate();

  @:from static inline function fromValue( value: String ): StringPredicate

    return ( input ) -> input == value;

  @:from static inline function fromBool( value: Bool ): StringPredicate

    return ( _ ) -> ( value );

  @:from static inline function fromMap( map: Map< String, Bool > ): StringPredicate

    return ( input ) -> ( map[ input ] );

  @:from static inline function fromArray( array: Array< String > ): StringPredicate

    return ( input ) -> array.indexOf( input ) != -1;

  @:from static inline function fromEReg( pattern: EReg ): StringPredicate

    return ( input ) -> pattern.match( input );


  public static inline function negate( predicate: StringPredicate ): StringPredicate

    return ( value ) -> ! predicate( value );

}
