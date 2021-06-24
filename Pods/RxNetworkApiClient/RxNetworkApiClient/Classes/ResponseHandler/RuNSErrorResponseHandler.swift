//
// Created by admin on 27.06.2018.
// Copyright (c) 2018 WebAnt. All rights reserved.
//

import Foundation


/// Русифицирует коды ошибок, которые могут вернуться от внутренней ошибки сети.
open class RuNSErrorResponseHandler: ResponseHandler {

    public init() {
    }

    public func handle<T: Codable>(observer: @escaping SingleObserver<T>,
                                   request: ApiRequest<T>,
                                   response: NetworkResponse) -> Bool {
        if let errorCode = (response.error as NSError?)?.code {
            let errorResponseEntity = ResponseErrorEntity(response.urlResponse)
            let errorMessage = errorCodeToMessage(errorCode)
            errorResponseEntity.errors.append(errorMessage)
            observer(.error(errorResponseEntity))
            return true
        }
        return false
    }

    open func errorCodeToMessage(_ code: Int) -> String {
        switch code {
            case -1011: return "Система загрузки URL-адресов получила плохие данные с сервера."
            case -1000: return "Недопустимый URL-адрес предотвратил запуск запроса URL-адреса."
            case -1019: return "Соединение было предпринято, когда телефонный звонок был активным в сети, которая не поддерживает одновременную телефонную и передачу данных (EDGE или GPRS)."
            case -999: return "Асинхронная загрузка отменена."
            case -3002: return "Задача загрузки не могла закрыть загруженный файл на диске."
            case -1004: return "Не удалось связаться с хостом."
            case -3000: return "Задача загрузки не могла создать загруженный файл на диске из-за сбоя ввода-вывода."
            case -1016: return "Контентные данные, полученные во время запроса на соединение, имели неизвестную кодировку содержимого."
            case -1015: return "Контентные данные, полученные во время запроса соединения, не могут быть декодированы для известной кодировки содержимого."
            case -1003: return "Имя хоста для URL-адреса не может быть разрешено."
            case -2000: return "Не удалось выполнить конкретный запрос на загрузку элемента только из кеша."
            case -3005: return "Экземпляр NSURLDownload не смог переместить загруженный файл на диск."
            case -3001: return "Экземпляр NSURLDownload не смог открыть загруженный файл на диске."
            case -1017: return "Ответ на запрос соединения не может быть проанализирован."
            case -3004: return "Экземпляр NSURLDownload не смог удалить загруженный файл с диска."
            case -3003: return "Экземпляр NSURLDownload не смог записать в загруженный файл на диске."
            case -1205: return "Сертификат сервера был отклонен."
            case -1206: return "Для проверки подлинности SSL-соединения во время запроса соединения требуется сертификат клиента."
            case -1020: return "Сотовая сеть запретила соединение."
            case -1006: return "Адрес хоста не найден с помощью поиска DNS."
            case -3006: return "Экземпляр NSURLDownload не смог декодировать закодированный файл во время загрузки."
            case -3007: return "Экземпляр NSURLDownload не смог декодировать закодированный файл после загрузки."
            case -1100: return "Файл не существует."
            case -1101: return "Запрос на FTP-файл привел к тому, что сервер ответил, что файл не является простым файлом, а является каталогом."
            case -1007: return "Был обнаружен цикл перенаправления или когда превышен порог для числа допустимых перенаправлений (в настоящее время 16)."
            case -1018: return "При попытке подключения необходимо активировать контекст данных во время роуминга, но международный роуминг отключен."
            case -1005: return "Соединение клиента или сервера было разорвано посередине незавершенной загрузки."
            case -1102: return "Невозможно прочитать ресурс из-за недостаточных разрешений."
            case -1009: return "Интернет-соединение не установлено"
            case -1010: return "Перенаправление было задано с помощью кода ответа сервера, но сервер не сопровождал этот код URL-адресом переадресации."
            case -1021: return "Необходим поток тела, но клиент не предоставил его. Это влияет на клиентов на iOS, которые отправляют запрос POST с использованием потока тела, но не реализуют метод делегирования NSURLSessionTaskDelegate"
            case -1008: return "Запрошенный ресурс не может быть восстановлен."
            case -1200: return "Попытка установить безопасное соединение не удалась по причинам, которые не могут быть выражены более конкретно."
            case -1201: return "У сертификата сервера была дата, указавшая, что срок ее действия илистек, или еще не действителен."
            case -1203: return "Серверный сертификат не был подписан ни одним корневым сервером."
            case -1204: return "Сертификат сервера еще не действителен."
            case -1202: return "Сертификат сервера был подписан корневым сервером, которому не доверяют."
            case -1001: return "Асинхронная операция завершена."
            case -1: return "Система загрузки URL-адресов обнаружила ошибку, которую она не может интерпретировать."
            case -1002: return "Правильно сформированный URL-адрес не может быть обработан каркасом."
            case -1013: return "Для доступа к ресурсу потребовалась аутентификация."
            case -1012: return "Пользователь асинхронного запроса на аутентификацию был отменен."
            case -1014: return "Сервер сообщил, что URL-адрес имеет ненулевую длину контента, но прекратил сетевое подключение изящно, не отправляя никаких данных."
            default:return "Необработанный код ошибки внутри приложения: \(code)"
        }
    }
}
