contract Counter {
    // import
    use dep::aztec::protocol_types::{
        abis::function_selector::FunctionSelector,
        address::AztecAddress,
    };
    use dep::aztec::{
        context::Context,
        state_vars::{map::Map, public_state::PublicState},
        types::type_serialization::field_serialization::{FieldSerializationMethods, FIELD_SERIALIZED_LEN},
    };

    // storage
    struct Storage {
        value: PublicState<Field, FIELD_SERIALIZED_LEN>,
    }

    impl Storage {
        fn init(context: Context) -> Self {
            Storage {
                value: PublicState::new(context, 1, FieldSerializationMethods),
            }
        }
    }

    #[aztec(private)]
    fn constructor() {}

    #[aztec(public)]
    unconstrained fn value() -> pub Field {
        storage.value.read()
    }

    #[aztec(public)]
    unconstrained fn increment() -> pub Field {
        let value = storage.value.read() + 1;
        storage.value.write(value);
        value
    }

    #[aztec(public)]
    unconstrained fn decrement() -> pub Field {
        let value = storage.value.read() - 1;
        storage.value.write(value);
        value
    }

    #[aztec(public)]
    unconstrained fn reset() -> pub Field {
        storage.value.write(0);
        0
    }

    unconstrained fn compute_note_hash_and_nullifier(
        contract_address: AztecAddress,
        nonce: Field,
        storage_slot: Field,
        serialized_note: [Field; 0]
    ) -> pub [Field; 4] {
        [0, 0, 0, 0]
    }
}
