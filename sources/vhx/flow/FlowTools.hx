package vhx.flow;


class FlowTools {

  public static inline function tap< T >( that: T, func: ( that: T ) -> Void ) {

    func( that );

    return that;

  }

  public static inline function pipe< T, R >( that: T, func: ( that: T ) -> R )

    return func( that );

}
