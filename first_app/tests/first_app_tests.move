module first_app::first_app_tests;

use first_app::first_app::{Self, Counter};
use sui::test_scenario;

#[test]
fun test_increment() {
    // Tạo kịch bản kiểm tra
    let mut scenario = test_scenario::begin(@0x1);
    let ctx = test_scenario::ctx(&mut scenario);

    // Gọi create_counter để khởi tạo Counter
    first_app::create_counter(ctx);

    // Lấy Counter từ shared object, khai báo với mut
    let mut counter = test_scenario::take_shared<Counter>(&scenario);

    // Kiểm tra giá trị ban đầu
    assert!(first_app::get_value(&counter) == 0, 0);

    // Gọi increment với tham chiếu mutable
    first_app::increment(&mut counter);
    assert!(first_app::get_value(&counter) == 1, 1);

    // Gọi increment lần nữa
    first_app::increment(&mut counter);
    assert!(first_app::get_value(&counter) == 2, 2);

    // Trả lại Counter và kết thúc kịch bản
    test_scenario::return_shared(counter);
    test_scenario::end(scenario);
}

#[test]
fun test_get_value() {
    // Tạo kịch bản kiểm tra
    let mut scenario = test_scenario::begin(@0x1);
    let ctx = test_scenario::ctx(&mut scenario);

    // Gọi create_counter để khởi tạo Counter
    first_app::create_counter(ctx);

    // Lấy Counter từ shared object, khai báo với mut
    let mut counter = test_scenario::take_shared<Counter>(&scenario);

    // Kiểm tra giá trị ban đầu
    assert!(first_app::get_value(&counter) == 0, 0);

    // Tăng giá trị và kiểm tra
    first_app::increment(&mut counter);
    assert!(first_app::get_value(&counter) == 1, 1);

    // Trả lại Counter và kết thúc kịch bản
    test_scenario::return_shared(counter);
    test_scenario::end(scenario);
}
