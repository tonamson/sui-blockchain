module first_app::first_app;

/// Struct đại diện cho biến tổng (counter)
public struct Counter has key {
    id: UID,
    value: u64,
}

/// Hàm init giữ nguyên, không có public
fun init(ctx: &mut TxContext) {
    let counter = Counter { id: object::new(ctx), value: 0 };
    transfer::share_object(counter);
}

/// Hàm public mới để khởi tạo Counter
public fun create_counter(ctx: &mut TxContext) {
    let counter = Counter { id: object::new(ctx), value: 0 };
    transfer::share_object(counter);
}

/// Hàm tăng giá trị của Counter lên 1
public entry fun increment(counter: &mut Counter) {
    counter.value = counter.value + 1;
}

/// Hàm đọc giá trị hiện tại của Counter
public fun get_value(counter: &Counter): u64 {
    counter.value
}
