contract Counter {
    // import
    use dep::aztec::prelude::{AztecAddress, PublicMutable};
    use dep::aztec::context::Context;

    // storage
    struct Storage {
        value: PublicMutable<Field>,
    }

    impl Storage {
        fn init(context: Context) -> Self {
            Storage {
                value: PublicMutable::new(context, 1),
            }
        }
    }

    #[aztec(private)]
    fn constructor() {}

    unconstrained fn value() -> pub Field {
        storage.value.read()
    }

    #[aztec(public)]
    fn increment() -> pub Field {
        let value = storage.value.read() + 1;
        storage.value.write(value);
        value
    }

    #[aztec(public)]
    fn decrement() -> pub Field {
        let value = storage.value.read() - 1;
        storage.value.write(value);
        value
    }

    #[aztec(public)]
    fn reset() -> pub Field {
        storage.value.write(0);
        0
    }
}
