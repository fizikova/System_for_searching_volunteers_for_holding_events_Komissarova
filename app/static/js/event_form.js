function initEventFormEditor() {
    const editorContainer = document.getElementById('markdown-editor');
    const textarea = document.getElementById('description-field');
    const errorElement = document.getElementById('description-error');
    
    if (!editorContainer || !textarea) return;
    
    // Проверяем, загружена ли библиотека EasyMDE
    if (typeof EasyMDE === 'function') {
        // Создаем редактор
        const easyMDE = new EasyMDE({
            element: document.createElement('textarea'),
            initialValue: textarea.value || '',
            spellChecker: false,
            autosave: { enabled: false },
            toolbar: [
                "bold", "italic", "heading", "|",
                "quote", "unordered-list", "ordered-list", "|",
                "link", "image", "|", "preview"
            ]
        });
        
        // Добавляем редактор в контейнер
        editorContainer.appendChild(easyMDE.codemirror.getWrapperElement());
        
        // Синхронизация значений
        easyMDE.codemirror.on("change", function() {
            textarea.value = easyMDE.value();
        });
        
        // Валидация при отправке формы
        const form = document.getElementById('event-form');
        if (form) {
            form.addEventListener('submit', function(e) {
                if (!easyMDE.value().trim()) {
                    e.preventDefault();
                    if (errorElement) {
                        errorElement.textContent = 'Описание обязательно для заполнения';
                    }
                    easyMDE.codemirror.focus();
                }
            });
        }
        
        // Скрытие ошибки при вводе
        easyMDE.codemirror.on("change", function() {
            if (errorElement && errorElement.textContent) {
                errorElement.textContent = '';
            }
        });
    } else {
        console.error('EasyMDE library not loaded');
        // Fallback: показываем обычное текстовое поле
        const fallbackTextarea = document.createElement('textarea');
        fallbackTextarea.className = 'form-control';
        fallbackTextarea.rows = 10;
        fallbackTextarea.value = textarea.value || '';
        editorContainer.appendChild(fallbackTextarea);
        
        // Синхронизация значений
        fallbackTextarea.addEventListener('input', function() {
            textarea.value = fallbackTextarea.value;
        });
    }
}

// Инициализация после загрузки DOM
document.addEventListener('DOMContentLoaded', function() {
    // Инициализируем редактор только на страницах создания/редактирования
    if (document.getElementById('event-form')) {
        initEventFormEditor();
    }
    
    // Инициализация отображения имени файла
    const fileInput = document.getElementById('image');
    if (fileInput) {
        const fileNameDisplay = document.createElement('span');
        fileNameDisplay.className = 'text-muted ms-2';
        fileNameDisplay.id = 'file-name';
        
        // Находим метку для файлового ввода и добавляем отображение имени файла
        const label = fileInput.previousElementSibling;
        if (label && label.tagName === 'LABEL') {
            label.appendChild(fileNameDisplay);
        }
        
        fileInput.addEventListener('change', function(e) {
            const fileName = e.target.files[0]?.name || 'Файл не выбран';
            fileNameDisplay.textContent = fileName;
        });
        
        // Инициализация при загрузке
        fileNameDisplay.textContent = fileInput.files[0]?.name || 'Файл не выбран';
    }
});