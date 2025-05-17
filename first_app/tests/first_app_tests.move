module first_app::first_app_tests {
    use first_app::first_app::{Self, Counter};
    use sui::test_scenario;

    #[test]
    fun test_increment() {
        // Bắt đầu kịch bản kiểm tra với một địa chỉ giả lập
        let mut scenario_val = test_scenario::begin(@0x1);
        let scenario = &mut scenario_val;

        // Giao dịch 1: Tạo Counter
        {
            let ctx = test_scenario::ctx(scenario);
            first_app::create_counter(ctx);
        };

        // Chuyển sang giao dịch tiếp theo để cập nhật trạng thái
        test_scenario::next_tx(scenario, @0x1);

        // Lấy Counter từ shared object
        let mut counter = test_scenario::take_shared<Counter>(scenario);

        // Kiểm tra giá trị ban đầu
        assert!(first_app::get_value(&counter) == 0, 0);

        // Giao dịch 2: Gọi increment lần 1
        {
            first_app::increment(&mut counter);
        };

        // Chuyển sang giao dịch tiếp theo
        test_scenario::next_tx(scenario, @0x1);

        // Kiểm tra giá trị sau khi tăng
        assert!(first_app::get_value(&counter) == 1, 1);

        // Giao dịch 3: Gọi increment lần 2
        {
            first_app::increment(&mut counter);
        };

        // Chuyển sang giao dịch tiếp theo
        test_scenario::next_tx(scenario, @0x1);

        // Kiểm tra giá trị sau khi tăng lần thứ hai
        assert!(first_app::get_value(&counter) == 2, 2);

        // Trả lại Counter và kết thúc kịch bản
        test_scenario::return_shared(counter);
        test_scenario::end(scenario_val);
    }

    #[test]
    fun test_get_value() {
        // Bắt đầu kịch bản kiểm tra với một địa chỉ giả lập
        let mut scenario_val = test_scenario::begin(@0x1);
        let scenario = &mut scenario_val;

        // Giao dịch 1: Tạo Counter
        {
            let ctx = test_scenario::ctx(scenario);
            first_app::create_counter(ctx);
        };

        // Chuyển sang giao dịch tiếp theo để cập nhật trạng thái
        test_scenario::next_tx(scenario, @0x1);

        // Lấy Counter từ shared object
        let mut counter = test_scenario::take_shared<Counter>(scenario);

        // Kiểm tra giá trị ban đầu
        assert!(first_app::get_value(&counter) == 0, 0);

        // Giao dịch 2: Gọi increment
        {
            first_app::increment(&mut counter);
        };

        // Chuyển sang giao dịch tiếp theo
        test_scenario::next_tx(scenario, @0x1);

        // Kiểm tra giá trị sau khi tăng
        assert!(first_app::get_value(&counter) == 1, 1);

        // Trả lại Counter và kết thúc kịch bản
        test_scenario::return_shared(counter);
        test_scenario::end(scenario_val);
    }
}