module first_app::first_app;

public struct Counter has key {
    id: UID,
    value: u64,
}

fun init(ctx: &mut TxContext) {
    let counter = Counter { id: object::new(ctx), value: 0 };
    transfer::share_object(counter);
}

public fun create_counter(ctx: &mut TxContext) {
    let counter = Counter { id: object::new(ctx), value: 0 };
    transfer::share_object(counter);
}

public entry fun increment(counter: &mut Counter) {
    counter.value = counter.value + 1;
}

public fun get_value(counter: &Counter): u64 {
    counter.value
}
