#include <QApplication>
#include <QMainWindow>
#include <QtSystemDetection>


int main(int argc, char** argv) {
	QApplication a(argc, argv);
	#ifndef Q_OS_MACOS
		a.setWindowIcon(QIcon(":/icon.png"));
	#endif

	QMainWindow w{};
	w.show();
	return a.exec();
}