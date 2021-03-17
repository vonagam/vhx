package vhx.funcs;


@:forward @:callable @:transitive

@:using( vhx.funcs.Comparer )

abstract Comparer< T >( ( left: T, right: T ) -> Int ) from ( left: T, right: T ) -> Int to ( left: T, right: T ) -> Int {

  @:from static function fromIntFunc< T >( mapper: ( value: T ) -> Int ): Comparer< T > {

    return ( left, right ) -> {

      final leftValue = mapper( left );

      final rightValue = mapper( right );

      return leftValue == rightValue ? 0 : leftValue > rightValue ? 1 : -1;

    };

  }

  @:from static function fromFloatFunc< T >( mapper: ( value: T ) -> Float ): Comparer< T > {

    return ( left, right ) -> {

      final leftValue = mapper( left );

      final rightValue = mapper( right );

      return leftValue == rightValue ? 0 : leftValue > rightValue ? 1 : -1;

    };

  }


  public static inline function reverse< T >( comparer: Comparer< T > ): Comparer< T >

    return ( left, right ) -> comparer( left, right ) * -1;

}
