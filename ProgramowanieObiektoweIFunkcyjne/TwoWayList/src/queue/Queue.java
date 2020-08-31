package queue;


public class Queue<T> {
    public int size = 0;
    public int maxSize;

    public Queue(int maxSize) {
        this.maxSize = maxSize;
    }

    public QueueElement<T> head;
    public QueueElement<T> tail;

    private class QueueElement<T> {

        T value;
        QueueElement<T> prev;
        QueueElement<T> next;

        private QueueElement(T newValue, QueueElement prev, QueueElement next) {
            this.value = newValue;
            this.prev = prev;
            this.next = next;
        }

    }

    public void pushTail(T newValue) {   // dodaje element na koniec kolejki
        if (size == maxSize) {
            throw new IllegalStateException("Queue overflow.");
        } else if (size == 0) {
            this.head = new QueueElement(newValue, null, null);
            this.tail = this.head;
            size++;
        } else {
            this.tail.next = new QueueElement(newValue, tail, null);
            this.tail = this.tail.next;
            size++;
        }
    }
    public void pushHead(T newValue){
        if (size == maxSize) {
            throw new IllegalStateException("Queue overflow.");
        }
        else if (size == 0) {
            this.head = new QueueElement(newValue, null, null);
            this.tail = this.head;
            size++;
        }
        else{
            this.head.prev = new QueueElement<>(newValue, null, head);
            this.head = this.head.prev;
            size ++;
        }
    }


    public T popHead() {         // usuwa element z poczatku kolejki
        if (size == 0) {
            throw new IllegalStateException("Empty queue");
        } else if (size == 1) {
            T val = this.head.value;
            this.head = this.head.next;
            size--;
            return val;
        } else {
            T val = this.head.value;
            this.head = this.head.next;
            this.head.prev = null;
            size--;
            return val;
        }
    }
    public T popTail(){
        if (size == 0) {
            throw new IllegalStateException("Empty queue");
        }
        else if (size == 1) {
            T val = this.head.value;
            this.head = this.head.next;
            size--;
            return val;
        }
        else {
            T val = this.tail.value;
            this.tail = this.head.prev;
            this.tail.next = null;
            size--;
            return val;}


    }
    public int getSize(){
        return this.size;
    }

    // Dodatkowe funkcje zaimplementowane w celu przetestowania prawidlowosci kolejki

    public T getHead() {
        return head.value;
    }

    public T getHeadPrev() {
        return head.prev.value;
    }

    public T getHeadNext() {
        return head.next.value;
    }

    public T getTailPrev() {
        return tail.prev.value;
    }

    public T getTail() {
        return tail.value;
    }
}