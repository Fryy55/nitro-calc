#include <QApplication>
#include <QMainWindow>
#include <QtSystemDetection>


int main(int argc, char** argv) {
	QApplication a(argc, argv);
	#ifdef Q_OS_LINUX
		a.setWindowIcon(QIcon(":/icon.png"));
	#endif

	QMainWindow w{};
	w.show();
	return a.exec();
}