items_count = 10
def process_data():
    for i in range(items_count):
        print(f"Элемент {i}")

def show_count():
    print(f"Количество: {items_count}")

if __name__ == "__main__":
    print(f"Значение x = {items_count}")
    process_data()
    show_count()